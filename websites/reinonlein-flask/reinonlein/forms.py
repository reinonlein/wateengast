from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, SubmitField
from wtforms.validators import DataRequired,Email,EqualTo
from wtforms import ValidationError


class InfoForm(FlaskForm):
    gast = StringField('Wat is je naam gast?')
    boekjes = StringField('En hoeveel boekjes wil je kopen?')
    submit = SubmitField('Submit')


class AddDatabaseForm(FlaskForm):
    woord = StringField('Welk woord wil je in mijn database stoppen?', validators=[DataRequired()])
    submit = SubmitField('Submit')


class DeleteDatabaseForm(FlaskForm):
    deletewoord = StringField('Of haal je er liever weer een woord uit?', validators=[DataRequired()])
    submit = SubmitField('Delete')
    

class LoginForm(FlaskForm):
    username = StringField('Username', validators=[DataRequired()])
    password = PasswordField('Password', validators=[DataRequired()])
    submit = SubmitField('Log In')


class RegistrationForm(FlaskForm):
    email = StringField('Email', validators=[DataRequired(),Email()])
    username = StringField('Username', validators=[DataRequired()])
    password = PasswordField('Password', validators=[DataRequired(), EqualTo('pass_confirm', message='Passwords Must Match!')])
    pass_confirm = PasswordField('Confirm password', validators=[DataRequired()])
    submit = SubmitField('Register!')

    def check_email(self, field):
        # Check if not None for that user email!
        if User.query.filter_by(email=field.data).first():
            raise ValidationError('Your email has been registered already!')

    def check_username(self, field):
        # Check if not None for that username!
        if User.query.filter_by(username=field.data).first():
            raise ValidationError('Sorry, that username is taken!')


