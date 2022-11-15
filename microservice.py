import logging

from flask import Flask, abort
from integration import compute, compute_all

app = Flask(__name__)
logging.basicConfig(filename='/home/stjepan/record.log', level=logging.DEBUG)

@app.route('/<lower>/<upper>')
def get_integral(lower, upper):
    app.logger.debug("-- in controller --")

    try:
        lower = float(lower)
        upper = float(upper)
    except:
        abort(400, "Wrong data type provided")

    return ", ".join([str(x) for x in compute_all(lower, upper)])

if __name__=="__main__":
    app.logger.debug("-- starting app --")
    app.run(host='0.0.0.0')