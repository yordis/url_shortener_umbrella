import http from "k6/http";
import {check} from "k6";

export const options = {
  stages: [
    {duration: '30s', target: 10},
    {duration: '30s', target: 20},
    {duration: '30s', target: 100},
    {duration: '30s', target: 500}
  ],
  thresholds: {
    http_reqs: ['rate>25'],
  },
};

export default () => {
  const resp = http.get("http://app-prod:4000/GkOu8gbocVL", {
    redirects: 0,
  });
  check(resp, {"status is 302": (r) => r.status === 302});
};
