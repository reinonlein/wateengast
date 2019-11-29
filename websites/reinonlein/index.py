import os
from flask import Flask, render_template, session, redirect, url_for, flash
from forms import InfoForm, AddDatabaseForm, DeleteDatabaseForm
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate


app = Flask(__name__)

app.config['SECRET_KEY'] = 'mysecretkey'

basedir = os.path.abspath(os.path.dirname(__file__))
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///' + os.path.join(basedir, 'gastbase.sqlite')
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)
Migrate(app, db)

class Woorden(db.Model):

    __tablename__ = 'woorden'

    id = db.Column(db.Integer, primary_key = True)
    woord = db.Column(db.Text)

    def __init__(self, woord):
        self.woord = woord

    def __repr__(self):
        return f"Er zit een {self.woord} in mijn database"

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

@app.route('/database', methods=['GET', 'POST'])
def database():


    addform = AddDatabaseForm()
    delform = DeleteDatabaseForm()

    if addform.woord.data and addform.validate():

        woord = addform.woord.data
        
        session['woord'] = addform.woord.data
        flash(f"Wat vet, je hebt zojuist een {session['woord']} in mijn database gestopt!")
        
        nieuw_woord = Woorden(woord)
        db.session.add(nieuw_woord)
        db.session.commit()
        
        return redirect(url_for('database'))

    if delform.deletewoord.data and delform.validate():

        deletewoord = delform.deletewoord.data
        
        session['deletewoord'] = delform.deletewoord.data
        flash(f"Hoppa, je hebt net een {session['deletewoord']} uit mijn database gehaald...")
        
        delete_woord = Woorden.query.filter_by(woord=deletewoord).first()
        db.session.delete(delete_woord)
        db.session.commit()
        
        return redirect(url_for('database'))

    woorden = Woorden.query.all()
    return render_template('database.html', addform=addform, delform=delform, woorden=woorden)


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