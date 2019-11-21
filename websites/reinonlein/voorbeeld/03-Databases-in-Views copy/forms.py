from flask_wtf import FlaskForm
from wtforms import StringField, IntegerField, SubmitField


class AddForm(FlaskForm):

    name = StringField('Name of Puppy:')
    submit = SubmitField('Add Puppy')


class DelForm(FlaskForm):

    id = IntegerField('Id Number of Puppy to Remove:')
    submit = SubmitField('Remove Puppy')


class OwnerForm(FlaskForm):

    ownername = StringField('Name of Owner:')
    pup_id = IntegerField('ID of puppy')
    submit = SubmitField('Add Owner')
