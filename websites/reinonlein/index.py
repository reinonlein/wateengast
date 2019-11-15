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

@app.route('/database')
def database():
    return render_template('database.html')

@app.errorhandler(404)
def page_not_found(e):
    return render_template('oeps.html'), 404

if __name__ == '__main__':
    app.run(debug=True)