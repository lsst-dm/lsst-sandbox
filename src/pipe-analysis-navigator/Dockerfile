FROM lsstdm/pipe-analysis-navigator-base:latest

COPY src/ /pipe-analysis-navigator/

WORKDIR /pipe-analysis-navigator

CMD panel serve dashboard_gen3.py --port 8080