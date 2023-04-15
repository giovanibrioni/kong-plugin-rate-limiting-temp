import http from 'k6/http';
import { Counter } from 'k6/metrics';

export const Counter429 = new Counter('Status429');
export const Counter200 = new Counter('Status200');

export const options = {
    vus: 20,
    iterations: 20,
    thresholds: {
        'Status429': ['count==19'],
        'Status200': ['count==1'],
      },
};


export default function () {
    const res = http.get('http://localhost:8000/admin');
    const status429 = res.status == 429
    const status200 = res.status == 200
    Counter429.add(status429);
    Counter200.add(status200);
}   
