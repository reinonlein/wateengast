from reinonlein import app,db
from flask import render_template, redirect, session, request, url_for, flash,abort
from flask_login import login_user,login_required,logout_user
from reinonlein.models import User, Woorden
from reinonlein.forms import LoginForm, RegistrationForm, AddDatabaseForm, DeleteDatabaseForm, InfoForm
from werkzeug.security import generate_password_hash, check_password_hash

###### ROUTES ######

@app.route('/')
def home():
    return render_template('home.html')

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



@app.route('/welcome')
@login_required
def welcome_user():
    return render_template('welcome_user.html')

@app.route('/logout')
@login_required
def logout():
    logout_user()
    flash('You logged out!')
    return redirect(url_for('home'))


@app.route('/login', methods=['GET', 'POST'])
def login():

    form = LoginForm()
    if form.validate_on_submit():
        # Grab the user from our User Models table
        user = User.query.filter_by(username=form.username.data).first()
        
        # Check that the user was supplied and the password is right
        # The verify_password method comes from the User object
        # https://stackoverflow.com/questions/2209755/python-operation-vs-is-not

        if user.check_password(form.password.data) and user is not None:
            #Log in the user

            login_user(user)
            flash('Logged in successfully.')

            # If a user was trying to visit a page that requires a login
            # flask saves that URL as 'next'.
            next = request.args.get('next')

            # So let's now check if that next exists, otherwise we'll go to
            # the welcome page.
            if next == None or not next[0]=='/':
                next = url_for('welcome_user')

            return redirect(next)
    return render_template('login.html', form=form)

@app.route('/register', methods=['GET', 'POST'])
def register():
    form = RegistrationForm()

    if form.validate_on_submit():
        user = User(email=form.email.data,
                    username=form.username.data,
                    password=form.password.data)

        db.session.add(user)
        db.session.commit()
        flash('Thanks for registering! Now you can login!')
        return redirect(url_for('login'))
    return render_template('register.html', form=form)

if __name__ == '__main__':
    app.run(debug=True)
