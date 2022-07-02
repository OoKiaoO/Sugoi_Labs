// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "controllers"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

// CHART.JS CONFIG
import Chart from 'chart.js/auto';

document.addEventListener('turbolinks:load', () => {
  const ctx = document.getElementById('myChart').getContext('2d');
  if (ctx) {
    const myChart = new Chart(ctx, {
      type: 'pie',
      data: {
        labels: JSON.parse(ctx.canvas.dataset.labels),
        datasets: [{
          data: JSON.parse(ctx.canvas.dataset.data),
          backgroundColor: [
            'rgba(234, 60, 182, 0.8)',
            'rgba(246, 135, 45, 0.8)',
            'rgba(95, 60, 234, 0.8)'
          ]
        }]
      },
      });
    }
})
