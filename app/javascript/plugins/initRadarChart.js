import {
  Chart,
  LineElement,
  PointElement,
  RadarController,
  RadialLinearScale,
  Decimation,
  Filler,
  Tooltip
} from 'chart.js';

Chart.register(
  LineElement,
  PointElement,
  RadarController,
  RadialLinearScale,
  Decimation,
  Filler,
  Tooltip
);

const initRadarChart = () => {
  const radarChart = document.getElementById('radar-chartjs');
  if (radarChart) {
    const labels = JSON.parse(radarChart.dataset.labels);
    const scores = JSON.parse(radarChart.dataset.scores);

    const data = {
      labels: labels,
      datasets: [{
        data: scores,
        fill: true,
        backgroundColor: 'rgba(41, 48, 68, 0.2)',
        borderColor: 'rgb(41, 48, 68)',
        pointBackgroundColor: 'rgb(41, 48, 68)',
        pointBorderColor: '#fff',
        pointHoverBackgroundColor: '#fff',
        pointHoverBorderColor: 'rgb(41, 48, 68)'
      }]
    };

    const options = {
      plugins: {
        tooltip: {
          displayColors: false
        }
      },
      maintainAspectRatio: true,
      scale: {
        max: 5,
        min: 0,
        stepSize: 1
      }
    };

    var myRadarChart = new Chart(radarChart, {
    type: 'radar',
    data: data,
    options: options
    });
  }
}

export { initRadarChart };
