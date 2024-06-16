/*
 *  nodes -- Display graphs for build node usages
 *  Copyright (C) 2022 Stephane Carrez
 *  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */

namespace Porion {

    function durationFormatter(v, axis) {
        let secs = v / 1000;
             let min = Math.floor(secs / 60);
             let hour = Math.floor(min / 60);
             if (hour > 0) {
                 min = min % 60;
                 secs = secs % 60;
                 return hour.toFixed(0) + ":" + min.toFixed(0) + ":" + secs.toFixed(0);
             }
             if (min > 0) {
                 secs = secs % 60;
                 return min.toFixed(0) + ":" + secs.toFixed(0);
             }
        return secs.toFixed(axis.tickDecimals) + " s";
    }

    export interface NodeUsage {
       build_duration: number,
       test_duration: number,
       sys_time: number,
       user_time: number,
       count: number,
       date: string,
       build_status: string
    }

    export interface Options {
        durationContainer: string,
        systemContainer: string
    }
    export class NodeUsageChart {
        readonly durationGraphContainer : HTMLDivElement = <HTMLDivElement>document.createElement('div');
        readonly systemGraphContainer : HTMLDivElement = <HTMLDivElement>document.createElement('div');
        readonly durationLegendContainer : HTMLDivElement = <HTMLDivElement>document.createElement('div');
        readonly systemLegendContainer : HTMLDivElement = <HTMLDivElement>document.createElement('div');
        readonly tooltipContainer : HTMLDivElement = <HTMLDivElement>document.createElement('div');
        durationContainer  : HTMLElement | null;
        systemContainer  : HTMLElement | null;
        node       : string = "";

        constructor(options : Options, node: string) {
            this.durationContainer = document.getElementById(options.durationContainer);
            if (this.durationContainer) {
               this.durationContainer.appendChild(this.durationGraphContainer);
               this.durationContainer.appendChild(this.durationLegendContainer);
               this.durationLegendContainer.className = 'graph-legend';
               this.durationGraphContainer.className = 'graph-view';
            }
            this.systemContainer = document.getElementById(options.systemContainer);
            if (this.systemContainer) {
               this.systemContainer.appendChild(this.systemGraphContainer);
               this.systemContainer.appendChild(this.systemLegendContainer);
               this.systemLegendContainer.className = 'graph-legend';
               this.systemGraphContainer.className = 'graph-view';
            }
            this.node = node;
            this.tooltipContainer.className = 'graph-tooltip';
            document.body.appendChild(this.tooltipContainer);
            this.getData(null)
        }
        getData(event : Event | null) {
            if (this.node) {
                const node : string = this.node;
                const xmlhttp : XMLHttpRequest = new XMLHttpRequest();
                
                xmlhttp.onload = evt => {
                    if (xmlhttp.status == 200 && (this.durationContainer || this.systemContainer)) {
                        this.updateData(JSON.parse(xmlhttp.response));
                    }
                };
                xmlhttp.open("GET", "/porion/api/v1/nodes/" + node + "/usage");
                xmlhttp.send();
            }
        }
        updateData(content : NodeUsage[]) {
           var build_duration_pass : number[] = new Array();
           var build_duration_fail : number[] = new Array();
           var user_time : number[] = new Array();
           var sys_time : number[] = new Array();
           var labels : string[] = new Array();
           var prevDate : string | null = null;
           var build_pass : NodeUsage | null = null;
           var build_fail : NodeUsage | null = null;
           for (var usage of content) {
              if (usage.date != prevDate) {
                 if (prevDate) {
                    var offset : number = 0;
                    var day_user_time : number = 0;
                    var day_sys_time : number = 0;
                    var day = Math.floor(new Date(prevDate).getTime() / 1000);
                    if (build_fail) {
                       build_duration_fail.push(build_fail.build_duration / 1000);
                       offset = build_fail.build_duration;
                       day_user_time = build_fail.user_time;
                       day_sys_time = build_fail.sys_time;
                    }
                    if (build_pass) {
                       build_duration_pass.push((build_pass.build_duration + offset) / 1000);
                       day_user_time += build_pass.user_time;
                       day_sys_time += build_pass.sys_time;
                    }
                    sys_time.push(day_sys_time / 1000);
                    user_time.push((day_sys_time + day_user_time) / 1000);
                    labels.push(prevDate);
                 }
                 prevDate = usage.date;
                 build_pass = null;
                 build_fail = null;
              }
              if (usage.build_status == "BUILD_PASS") {
                 build_pass = usage;
              } else {
                 build_fail = usage;
              }
           }
           if (prevDate) {
              var offset : number = 0;
              var day_user_time : number = 0;
              var day_sys_time : number = 0;
              var day = Math.floor(new Date(prevDate).getTime() / 1000);
              if (build_fail) {
                 build_duration_fail.push(build_fail.build_duration / 1000);
                 offset = build_fail.build_duration;
                 day_user_time = build_fail.user_time;
                 day_sys_time = build_fail.sys_time;
              }
              if (build_pass) {
                 build_duration_pass.push((build_pass.build_duration + offset) / 1000);
                 day_user_time += build_pass.user_time;
                 day_sys_time += build_pass.sys_time;
              }
              labels.push(prevDate);
              sys_time.push(day_sys_time / 1000);
              user_time.push((day_sys_time + day_user_time) / 1000);
           }
           if (this.durationContainer) {
               const data : Frappe.ChartData = {
                   labels: labels,
                   datasets: [{
                       name: "Pass build duration",
                       type: "line",
                       values: build_duration_pass
                   }, {
                       name: "Failed build duration",
                       type: "line",
                       values: build_duration_fail
                   }]
               };
               const chart : Frappe.Chart = new Frappe.Chart(this.durationContainer, {
                  // title: "CPU Usage",
                  animate: 0,
                  data: data,
                  type: 'axis-mixed', // or 'bar', 'line', 'scatter', 'pie', 'percentage'
                  height: 250,
                  valuesOverPoints: 0,
                  lineOptions: {
                     regionFill: 1,
                     dotSize: 2
                  },
                  tooltipOptions: {
                     formatTooltipY: (value : number) => {
                        let min = value / 60;
                        let sec = value % 60;
                        if (min > 0) {
                           return String(min.toFixed(0)) + ":" + ('00'+sec).slice(-2);
                        }
                        return sec;
                     }
                  },
                  colors: ['#7cd6fd', '#743ee2']
               })
           }
           if (this.systemContainer) {
               const data : Frappe.ChartData = {
                  labels: labels,
                  datasets: [{
                     name: "User time",
                     type: "line",
                     values: user_time
                  }, {
                     name: "System time",
                     type: "line",
                     values: sys_time
                  }]
               };
               const chart : Frappe.Chart = new Frappe.Chart(this.systemContainer, {
                  // title: "CPU Usage",
                  animate: 0,
                  data: data,
                  type: 'axis-mixed', // or 'bar', 'line', 'scatter', 'pie', 'percentage'
                  height: 250,
                  valuesOverPoints: 0,
                  lineOptions: {
                     regionFill: 1,
                     dotSize: 2
                  },
                  tooltipOptions: {
                     formatTooltipY: (value : number) => {
                        let min = value / 60;
                        let sec = value % 60;
                        if (min > 0) {
                           return String(min.toFixed(0)) + ":" + ('00'+sec).slice(-2);
                        }
                        return sec;
                     }
                  },
                  colors: ['#7cd6fd', '#743ee2']
               })
         }
      }
    }
}
