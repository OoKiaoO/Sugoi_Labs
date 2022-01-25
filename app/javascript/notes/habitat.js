// CHARTS VIEW FROM HABITAT (my_stats.html.erb)

{/* <div class='container'>
  <div class="stats-title">
    <h1>My Stats</h1>
    <p id="back"><%= link_to "Back", profile_path %></p>
  </div>
  <div class="charts">
    <div class="cigarettes-chart">
      <canvas id="cigChart" width="80%" height="50%" data-cigs="<%= @date_cigs %>"></canvas>
    </div>

    <div class="cigarettes-chart">
      <canvas id="feelingsChart" width="80%" height="50%" data-feelings="<%= @feelings_count.to_json %>"></canvas>
    </div>

    <div class="cigarettes-chart">
      <canvas id="contextChart" width="80%" height="50%" data-context="<%= @context_count.to_json %>"></canvas>
    </div>
  </div>

  <%= javascript_pack_tag 'cigs-chart' %>
  <%= javascript_pack_tag 'context-chart' %>
  <%= javascript_pack_tag 'feelings-chart' %>
</div> */}

// CHARTS ASSOCIATED JS FILES
// cigs-chart.js

import Chart from 'chart.js';
import moment from 'moment';

const ctx = document.getElementById('cigChart');
const dataArray = ctx.dataset.cigs;
const dataJSON = JSON.parse(dataArray);
const chartData = [];

dataJSON.forEach(elem => {
  const obj = {
    x: moment(elem[0]),
    y: elem[1]
  };
  chartData.push(obj);
});

const myChart = new Chart(ctx, {
    type: 'line',
    data: {
        // labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
        labels: chartData.map(obj=> obj.x),
        datasets: [{
            label: '# of Cigarettes Smoked',
            data: chartData,
            backgroundColor: [
                'rgba(0, 166, 122, 0.2)',
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)',
                'rgba(255, 159, 64, 0.2)'
            ],
            borderColor: [
                'rgba(0, 166, 122, 1)',
                'rgba(255, 99, 132, 1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(153, 102, 255, 1)',
                'rgba(255, 159, 64, 1)'
            ],
            borderWidth: 1
        }]
    },
    options: {
        scales: {
            xAxes: [{
                ticks: {
                    beginAtZero: true
                },
                type : 'time',
                time: {
                  unit: 'month'
                }
            }]
        }
    }
});

// context-chart.js

import Chart from 'chart.js';
import moment from 'moment';

const ctx = document.getElementById('contextChart');
const dataArray = ctx.dataset.context;
const contextObj = JSON.parse(dataArray);
console.log(contextObj);

const myChart = new Chart(ctx, {
    type: 'pie',
    data: {
        labels: Object.keys(contextObj),
        datasets: [{
            label: '# of Cigarettes Smoked',
            data: Object.values(contextObj),
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)',
                'rgba(255, 159, 64, 0.2)'
            ],
            borderColor: [
                'rgba(255, 99, 132, 1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(153, 102, 255, 1)',
                'rgba(255, 159, 64, 1)'
            ],
            borderWidth: 1
        }]
    },
    options: {
        layout: {
            padding: {
                left: 50,
                right: 0,
                top: 0,
                bottom: 0
            }
        }
    }
});

// feelings-chart.js

import Chart from 'chart.js';
import moment from 'moment';

const ctx = document.getElementById('feelingsChart');
const dataArray = ctx.dataset.feelings;
const feelingsObj = JSON.parse(dataArray);


const myChart = new Chart(ctx, {
    type: 'doughnut',
    data: {
        labels: Object.keys(feelingsObj),
        datasets: [{
            label: '# of Cigarettes Smoked',
            data: Object.values(feelingsObj),
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)',
                'rgba(255, 159, 64, 0.2)'
            ],
            borderColor: [
                'rgba(255, 99, 132, 1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(153, 102, 255, 1)',
                'rgba(255, 159, 64, 1)'
            ],
            borderWidth: 1
        }]
    },
    options: {
        scales: {
            
        }
    }
});

// ENTRIES CONTROLLER

// class EntriesController < ApplicationController
//   before_action :find_entry, only: [:show, :destroy]

//   def index
//     @entries = policy_scope(Entry).order(date: :desc)
//   end

//   def show
//   end

//   def new
//     @entry = Entry.new
//     authorize @entry
//   end

//   def create
//     @entry = Entry.new(entry_params)
//     @entry.user = current_user
//     authorize @entry
//     if @entry.save
//       redirect_to entries_path
//     else
//       render :new
//     end
//   end

//   def destroy
//     @entry.destroy

//     redirect_to entries_path
//   end

//   def my_stats
//     @cig_entries = Entry.where('cig_smoked > 0 AND user_id = ?', current_user.id).order(date: :asc)
//     @date_cigs = reduce_same_date_entries(@cig_entries)

//     @entries = Entry.all
//     @feelings = get_feelings(@entries)
//     @context  = get_context(@entries)

//     @feelings_count = get_count(@feelings)
//     @context_count = get_count(@context)

//     authorize @cig_entries
//   end

//   private

//   def find_entry
//     @entry = Entry.find(params[:id])
//     authorize @entry
//   end

//   def entry_params
//     params.require(:entry).permit(:date, :feeling, :craving, :cig_smoked, :context)
//   end

//   # def reduce_same_date_entries(entries)
//   #   date_cig = []
//   #   entries.each do |entry|
//   #     dates = date_cig.map { |ary| ary[0] }
//   #     if date_cig.empty? || !dates.include?(entry.date.to_s)
//   #       cig_entry = [
//   #         entry.date.to_s,
//   #         entry.cig_smoked
//   #       ]
//   #       date_cig << cig_entry
//   #     else
//   #       existing_date = date_cig.select { |ary| ary[0] == entry.date.to_s }
//   #       existing_date[0][1] += entry.cig_smoked
//   #     end
//   #   end
//   #   date_cig
//   # end

//   def get_feelings(entries)
//     entries.map { |entry| entry.feeling }
//   end

//   def get_context(entries)
//     entries.map { |entry| entry.context }
//   end

//   def get_count(array)
//     counts = Hash.new(0)
//     array.each { |elem| counts[elem] += 1 }
//     sorted_counts = counts.sort_by { |k, v| -v }
//     sorted_counts.first(5).to_h
//   end
// end


// SORTING ALPHABETICALLY

{/* <ul id="id01">
  <li>Oslo</li>
  <li>Stockholm</li>
  <li>Helsinki</li>
  <li>Berlin</li>
  <li>Rome</li>
  <li>Madrid</li>
</ul> */}


// function sortListDir() {
//   var list, i, switching, b, shouldSwitch, dir, switchcount = 0;
//   list = document.getElementById("id01");
//   switching = true;
//   // Set the sorting direction to ascending:
//   dir = "asc";
//   // Make a loop that will continue until no switching has been done:
//   while (switching) {
//     // Start by saying: no switching is done:
//     switching = false;
//     b = list.getElementsByTagName("LI");
//     // Loop through all list-items:
//     for (i = 0; i < (b.length - 1); i++) {
//       // Start by saying there should be no switching:
//       shouldSwitch = false;
//       /* Check if the next item should switch place with the current item,
//       based on the sorting direction (asc or desc): */
//       if (dir == "asc") {
//         if (b[i].innerHTML.toLowerCase() > b[i + 1].innerHTML.toLowerCase()) {
//           /* If next item is alphabetically lower than current item,
//           mark as a switch and break the loop: */
//           shouldSwitch = true;
//           break;
//         }
//       } else if (dir == "desc") {
//         if (b[i].innerHTML.toLowerCase() < b[i + 1].innerHTML.toLowerCase()) {
//           /* If next item is alphabetically higher than current item,
//           mark as a switch and break the loop: */
//           shouldSwitch= true;
//           break;
//         }
//       }
//     }
//     if (shouldSwitch) {
//       /* If a switch has been marked, make the switch
//       and mark that a switch has been done: */
//       b[i].parentNode.insertBefore(b[i + 1], b[i]);
//       switching = true;
//       // Each time a switch is done, increase switchcount by 1:
//       switchcount ++;
//     } else {
//       /* If no switching has been done AND the direction is "asc",
//       set the direction to "desc" and run the while loop again. */
//       if (switchcount == 0 && dir == "asc") {
//         dir = "desc";
//         switching = true;
//       }
//     }
//   }
// }