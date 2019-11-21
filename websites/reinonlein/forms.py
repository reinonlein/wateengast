from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField

class InfoForm(FlaskForm):
    gast = StringField('Wat is je naam gast?')
    boekjes = StringField('En hoeveel boekjes wil je kopen?')
    submit = SubmitField('Submit')

class AddDatabaseForm(FlaskForm):
    woord = StringField('Welk woord wil je in mijn database stoppen?')
    submit = SubmitField('Submit')

class DeleteDatabaseForm(FlaskForm):
    woord = StringField('Welk woord wil je uit mijn database verwijderen?')
    submit = SubmitField('Submit')