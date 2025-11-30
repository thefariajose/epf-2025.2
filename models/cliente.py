import json
import os
from dataclasses import dataclass, asdict
from typing import List, Optional
from models.locacao import Locacao

#classe do usuário como clientes Model
DATA_DIR = os.path.join(os.path.dirname(__file__), '..', 'data')

class Cliente:
    def __init__(self, id, name, email, password, telephone, is_locador, cpf , endereco, historico_aluguel : list = None,  locacao_atual = None):
        self.id = id
        self.name = name
        self.email = email
        self.password = password
        self.telephone = telephone
        self.is_locador = is_locador
        self.cpf = cpf
        self.endereco = endereco
        self.historico_aluguel = historico_aluguel
        self.locacao_atual = locacao_atual
        self.historico_aluguel = historico_aluguel if historico_aluguel else []
        self.locacao_atual = locacao_atual

    def __repr__(self):
        return (f"Cliente(id={self.id}, name='{self.name}', email='{self.email}', "
                f"password='{self.password}', telephone='{self.telephone}',"
                f"is_locador='{self.is_locador}', cpf='{self.cpf}',"
                f"endereco='{self.endereco}', historico_aluguel='{self.historico_aluguel}',"
                f"locacao_atual='{self.locacao_atual}')")

    def to_dict(self):

        locacao_atual_dict = None
        if self.locacao_atual:
            #Pega o atributo (locação) e transforma em dicionário
            locacao_atual_dict = self.locacao_atual.to_dict()

        historico_list = []
        for locacao in self.historico_aluguel:
            #Trasforma todas as locações do atribto e também transforma em dicionário
            historico_list.append(locacao.to_dict())

        return {
            'id': self.id,
            'name': self.name,
            'email': self.email,
            'password': self.password,
            'telephone': self.telephone,
            'is_locador': self.is_locador,
            'cpf': self.cpf,
            'endereco': self.endereco,
            'historico_aluguel': historico_list,  
            'locacao_atual': locacao_atual_dict 
        }

    @classmethod
    def from_dict(cls, data):

        locacao_obj = None
        if data.get('locacao_atual'):
            # Transforma o dicionário de locação atual em Objeto
            locacao_obj = Locacao.from_dict(data['locacao_atual']) 

        historico_objs = []
        if data.get('historico_aluguel'):
            # Mesma coisa
            for item in data['historico_aluguel']:
                historico_objs.append(Locacao.from_dict(item))

        return cls(
            id=data['id'],
            name=data['name'],
            email=data['email'],
            password=data['password'],
            telephone=data['telephone'],
            is_locador=data['is_locador'],
            cpf=data['cpf'],
            endereco=data['endereco'],
            historico_aluguel=historico_objs, 
            locacao_atual=locacao_obj         
        )


class ClienteModel:
    FILE_PATH = os.path.join(DATA_DIR, 'clientes.json')
    
    def __init__(self):
        self.clientes = self._load()

    def _load(self):
        if not os.path.exists(self.FILE_PATH):
            return []
        with open(self.FILE_PATH, 'r', encoding='utf-8') as f:
            data = json.load(f)
            # JSON é meio burro, então ele pegaria o Objeto Locação e trasnformaria em um dicionário, e não em Objeto
            return [Cliente.from_dict(item) for item in data]

    def _save(self):
        with open(self.FILE_PATH, 'w', encoding='utf-8') as f:
            json.dump([c.to_dict() for c in self.clientes], f, indent=4, ensure_ascii=False)

    def get_all(self):
        return self.clientes

    def get_by_id(self, cliente_id: int):
        return next((c for c in self.clientes if c.id == cliente_id), None)

    def add_cliente(self, cliente: Cliente):
        self.clientes.append(cliente)
        self._save()

    def update_cliente(self, updated_cliente: Cliente):
        for i, cliente in enumerate(self.clientes):
            if cliente.id == updated_cliente.id:
                self.clientes[i] = updated_cliente
                self._save()
                break

    def delete_cliente(self, cliente_id: int):
        self.clientes = [c for c in self.clientes if c.id != cliente_id]
        self._save()
