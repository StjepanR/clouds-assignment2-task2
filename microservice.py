from flask import Flask, abort
from integration import compute, compute_all

app = Flask(__name__)

@app.route('/<lower>/<upper>')
def get_integral(lower, upper):
    try:
        lower = float(lower)
        upper = float(upper)
    except:
        abort(400, "Wrong data type provided")

    return compute_all(lower, upper)

if __name__=="__main__":
    app.run(host='0.0.0.0')