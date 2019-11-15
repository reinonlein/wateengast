from flask import Flask, render_template

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/contact')
def contact():
    return render_template('contact.html')

@app.route('/werk')
def werk():
    return render_template('werk.html')

@app.route('/over_mij')
def over_mij():
    return render_template('over_mij.html')

if __name__ == '__main__':
    app.run(debug=True)