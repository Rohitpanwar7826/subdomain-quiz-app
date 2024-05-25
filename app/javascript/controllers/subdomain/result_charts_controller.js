import { Controller } from "@hotwired/stimulus"
import { Chart, registerables } from 'chart.js';
Chart.register(...registerables);
// Connects to data-controller="subdomain--result-charts"
export default class extends Controller {
  connect() {
    const ctx = document.getElementById('result-chart');
    const dataSets = this.getDataSet();
    new Chart(ctx, {
      type: 'pie',
      data: {
        labels: [
          'Total Marks',
          "Your's",
        ],
        datasets: [{
          data: [...dataSets],
          backgroundColor: [
            'rgb(255, 0, 0)',
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
                size: 18,
              }
            }
          },
          tooltip: {
            padding: 5,
            boxPadding: 10,
            titleMarginBottom: 10,
            titleSpacing: 20
          }
        },
      }
    });
  }
  totalWieghtSum(prevWeight, acculumater) {
    return prevWeight+parseInt(acculumater.weight)
  }
  correctWieghtSum(prevWeight, acculumater) {
    if(acculumater.is_correct) {
      return prevWeight+parseInt(acculumater.weight)
    }
    return prevWeight;
  }

  getDataSet() {
    const resultChartDataStringfy = document.getElementById("charts_data").getAttribute("data-reports")
    const resultChartData = JSON.parse(resultChartDataStringfy)
    let totalWieght = resultChartData.reduce(this.totalWieghtSum, 0)
    let correctWieght = resultChartData.reduce(this.correctWieghtSum, 0)
    if(totalWieght === correctWieght) {
      totalWieght = 0;
    }
    return [ totalWieght, correctWieght ]
  }
}
