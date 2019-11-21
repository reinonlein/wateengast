"""nieuwe kolom

Revision ID: a831e390c391
Revises: 8b05b6370c2c
Create Date: 2019-11-20 23:14:00.564140

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = 'a831e390c391'
down_revision = '8b05b6370c2c'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('owners', sa.Column('name', sa.Text(), nullable=True))
    op.drop_column('owners', 'ownername')
    op.drop_column('owners', 'owner')
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('owners', sa.Column('owner', sa.TEXT(), nullable=True))
    op.add_column('owners', sa.Column('ownername', sa.TEXT(), nullable=True))
    op.drop_column('owners', 'name')
    # ### end Alembic commands ###
