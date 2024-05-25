import { Controller } from "@hotwired/stimulus"
import Progressbar from 'progressbar.js';

// Connects to data-controller="home"
export default class extends Controller {
  connect() {
    const dailyProgresData = JSON.parse(document.getElementById("daily_progres_data").getAttribute("data-results"))
    const totalResultCount = dailyProgresData['total_result_count'];
    const totalPassedResultCount = dailyProgresData['total_passed_result_count'];
    let divideProgress = totalPassedResultCount/totalResultCount;
    let dailyProgressInPercentage = (divideProgress)*100 ;
    if(totalPassedResultCount === 0 && totalResultCount === 0) {
      divideProgress = 0;
      dailyProgressInPercentage = 0;
    }
    var bar = new Progressbar.Line("#progress"  , {
      strokeWidth: 10,
      easing: 'easeInOut',
      duration: 1400,
      color: 'red',
      trailColor: '#eee',
      trailWidth: 10,
      svgStyle: {width: '100%', height: '2vh'},
      text: {
        style: {
          color: 'green',
          position: 'absolute',
          right: '0',
          top: '30px',
          padding: 10,
          margin: 0,
          transform: null
        },
        autoStyleContainer: true
      },
      
      from: {color: '#FFEA82'},
      to: {color: '#ED6A5A'},
      step: (state, bar) => {
        bar.setText(dailyProgressInPercentage + ' %');
      }
    });
    bar.animate(divideProgress);
  }
}
