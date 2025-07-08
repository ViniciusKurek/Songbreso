from db import init_db, session
from models import User

init_db()

# Criar um usuário
novo_user = User(
    id_user=1,
    img_user='img1.jpg',
    name='Lucas',
    password='1234',
    gender='Male',
    birth='1995-05-01',
    is_active=True
)

session.add(novo_user)
session.commit()

print("Usuário inserido com sucesso.")
