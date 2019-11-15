from flask import Flask, render_template, session, redirect, url_for, flash
from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField
from wtforms.validators import DataRequired

app = Flask(__name__)

app.config['SECRET_KEY'] = 'mysecretkey'


class InfoForm(FlaskForm):
    gast = StringField('Wat is je naam gast?')
    boekjes = StringField('En hoeveel boekjes wil je kopen?')
    submit = SubmitField('Submit')


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


@app.route('/naamgast', methods=['GET', 'POST'])
def naamgast():

    form = InfoForm()

    if form.validate_on_submit():

        session['gast'] = form.gast.data
        session['boekjes'] = form.boekjes.data
        flash(f"Ah, je naam is: {session['gast']} gast")
        flash(f"Toe maar, en je wilt maar liefst {session['boekjes']} boekjes kopen zeg! Wauw...")
        return redirect(url_for('naamgast'))

    return render_template('naamgast.html', form=form)


if __name__ == '__main__':
    app.run(debug=True)