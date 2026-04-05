import http from 'k6/http';
import { sleep, check } from 'k6';

export const options = {
    stages: [
        { target: 1000, duration: '1m' },
        { target: 5000, duration: '10m' },
    ],
};

export default function () {
    your_loadBalancer_url_here = ""
    const res = http.get(`http://${your_loadBalancer_url_here}/api/v1/todos`);
    check(res, { 'status was 200': (r) => r.status == 200 });
    sleep(1);
}

