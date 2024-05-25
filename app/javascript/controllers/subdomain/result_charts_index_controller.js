import { Controller } from "@hotwired/stimulus"
import { Chart, registerables } from 'chart.js';
Chart.register(...registerables);

// Connects to data-controller="subdomain--result-charts-index"
export default class extends Controller {
  connect() {
    const ctx = document.getElementById('result-charts-index');
    const dataSets = this.getDataSet();
    new Chart(ctx, {
      type: 'pie',
      data: {
        labels: [
          'Total Results',
          'Passed Results',
        ],
        datasets: [{
          data: [...dataSets],
          backgroundColor: [
            'rgb(113, 75, 252)',
            'rgb(0, 255, 1)',
          ],
          hoverOffset: 1
        }]
      },
      options: {
        plugins: {
          legend: {
            labels: {
              font: {
                size: 15,
                weight: 'bolder',
              },
              padding: 15,
              boxPadding: 10,
              textAlign: "left"
            }
          },
          tooltip: {
            padding: 5,
            boxPadding: 10,
            titleMarginBottom: 10,
            titleSpacing: 10
          }
        },
      }
    });
  }

  correctResultSum(prevResult, acculumater) {
    if(acculumater.pass_or_fail === "passed") {
      return prevResult+1;
    }
    return prevResult;
  }

  getDataSet() {
    const resultChartDataStringfy = document.getElementById("charts_data").getAttribute("data-results");
    const resultChartData = JSON.parse(resultChartDataStringfy);
    let totalResults = resultChartData.length;
    let correctResults = resultChartData.reduce(this.correctResultSum, 0);
    if(totalResults === correctResults) {
      totalResults = 0;
    }
    return [totalResults, correctResults];
  }
}
