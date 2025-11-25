import json
import os
from dataclasses import dataclass, asdict
from typing import List

#os.path.join usa 3 parametros, o 1° q é o os.path.dirname que pega o lugar onde o arquivo atual está,
# 2° o .. que diz para avançar ou recuar nas pastas e o 3° 'data' que é o nome da pasta
#essa função combina os 3 e faz o caminho pra salvar o arquivo na pasta data, DATA_DIR recebe exatamente isso, como uma string

DATA_DIR = os.path.join(os.path.dirname(__file__), '..', 'data')

#definição dos atributos base da classe user
class User:
    #Constructor
    def __init__(self, id, name, email, password, telephone):
        self.id = id
        self.name = name
        self.email = email
        self.password = password
        self.telephone = telephone

    #Função para representar os valores
    def __repr__(self):
        return (f"User(id={self.id}, name='{self.name}', email='{self.email}', "
                f"password='{self.password}', telephone='{self.telephone}')")

    #Função para converter em dicionário para usar to string dps
    def to_dict(self):
        return {
            'id': self.id,
            'name': self.name,
            'email': self.email,
            'password': self.password,
            'telephone': self.telephone
        }

    #recebe do dicionário e cria uma lista
    @classmethod
    def from_dict(cls, data):
        return cls(
            id=data['id'],
            name=data['name'],
            email=data['email'],
            password=data['password'],
            telephone=data['telephone']
        )


class UserModel:
    #Pega o caminho já feito da pasta e adiciona users.json no final dele
    FILE_PATH = os.path.join(DATA_DIR, 'users.json')
    
    #Constructors
    def __init__(self):
        self.users = self._load()

    #load ele carrega o arquivo
    def _load(self):
        #verifica se tem algum caminho de arquivo, se não existir retorna uma lista vazia para evitar excessão
        if not os.path.exists(self.FILE_PATH):
            return []
        #se tem ele abre o caminho do arquivo, lê e usa utf8 como encoding pra manter acentos, isso tudo como f, f é todo esse processo
        with open(self.FILE_PATH, 'r', encoding='utf-8') as f:
            #aqui json.load pega f e converte em uma lista de dicionários em python
            data = json.load(f)
            #return retorna um objeto Usuário usando as keys do dicionário como nomes dos atributos e os valores como, valores,
            #cria um loop ai e cada item seria cada dicionário em data, que foi criado mais cedo, agora esse **faz a mágica e organiza o dict em objeto
            return [User(**item) for item in data]

    #save salva
    def _save(self):
        #abre o lugar do arquivo, escreve por cima em utf8 e f recebe isso
        with open(self.FILE_PATH, 'w', encoding='utf-8') as f:
            #aqui o json dump pega os arquivos e salva em um dicionário (loop ai faz isso, u em self.users/objetos users)
            #o f é aonde ele vai fazer isso, indent =4 é indentação e o outro é caracter tb
            json.dump([u.to_dict() for u in self.users], f, indent=4, ensure_ascii=False)

    #método get
    def get_all(self):
        return self.users

    #método get pelo ID se o id no loop bate com o id dado pelo usuário, como um método de pesquisa, o next pega o seguinte sempre e se não conseguir, para não retornar
    #vazio e quebrar o código, none por ultimo
    def get_by_id(self, user_id: int):
        return next((u for u in self.users if u.id == user_id), None)

    #adiciona usuários para a lista de usuários e repete o processo de salvar lá
    def add_user(self, user: User):
        self.users.append(user)
        self._save()

    #atualiza os dados, ele usa i e o próprio usuário, enumera pra ter o índice e é pra isso q serve o i ai
    #verifica se o id de user é o mesmo da classe procurada, atualiza os dados da classe índice, salva naquele método e break
    def update_user(self, updated_user: User):
        for i, user in enumerate(self.users):
            if user.id == updated_user.id:
                self.users[i] = updated_user
                self._save()
                break

    #a lista self.users recebe todos os usuários diferentes do selecionado para ser apagado, após isso ele salva a nova lista e tira o escolhido
    def delete_user(self, user_id: int):
        self.users = [u for u in self.users if u.id != user_id]
        self._save()
