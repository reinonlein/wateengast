from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField
from wtforms.validators import DataRequired

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