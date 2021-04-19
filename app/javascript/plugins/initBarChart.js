import {
  Chart,
  ArcElement,
  LineElement,
  BarElement,
  PointElement,
  BarController,
  BubbleController,
  DoughnutController,
  LineController,
  PieController,
  PolarAreaController,
  RadarController,
  ScatterController,
  CategoryScale,
  LinearScale,
  LogarithmicScale,
  RadialLinearScale,
  TimeScale,
  TimeSeriesScale,
  Decimation,
  Filler,
  // Legend,
  Title,
  Tooltip
} from 'chart.js';

Chart.register(
  ArcElement,
  LineElement,
  BarElement,
  PointElement,
  BarController,
  BubbleController,
  DoughnutController,
  LineController,
  PieController,
  PolarAreaController,
  RadarController,
  ScatterController,
  CategoryScale,
  LinearScale,
  LogarithmicScale,
  RadialLinearScale,
  TimeScale,
  TimeSeriesScale,
  Decimation,
  Filler,
  // Legend,
  Title,
  Tooltip
);

const initBarChart = () => {
  const barCharts = document.querySelectorAll('.bar-chartjs');
  barCharts.forEach((barChart) => {
    if (barChart) {
      const labels = JSON.parse(barChart.dataset.labels);
      const completions = JSON.parse(barChart.dataset.completions);
      const backColors = [];
      const borderColors = [];
      completions.forEach((completion) => {
        if (completion === 0) {
          backColors.push('rgba(255, 99, 132)');
          borderColors.push('rgb(255, 99, 132)');
        } else if (completion < 50) {
          backColors.push('rgba(255, 99, 132, 0.2)');
          borderColors.push('rgb(255, 99, 132)');
        } else if (completion < 100) {
          backColors.push('rgba(255, 205, 86, 0.2)');
          borderColors.push('rgb(255, 205, 86)');
        } else if (completion === 100) {
          backColors.push('rgba(75, 192, 192, 0.2)');
          borderColors.push('rgb(75, 192, 192)');
        }
      })

      const data = {
        labels: labels,
        datasets: [{
          data: completions,
          // fill: true,
          backgroundColor: backColors,
          borderColor: borderColors,
          borderWidth: 1,
          minBarThickness: 10,
          maxBarThickness: 70,
          minBarLength: 2,
          // pointBackgroundColor: 'rgb(41, 48, 68)',
          // pointBorderColor: '#fff',
          // pointHoverBackgroundColor: '#fff',
          // pointHoverBorderColor: 'rgb(41, 48, 68)'
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
          max: 100,
          min: 0
        }
      };

      var myBarChart = new Chart(barChart, {
      type: 'bar',
      data: data,
      options: options
      });
    }
  });
};

export { initBarChart };
