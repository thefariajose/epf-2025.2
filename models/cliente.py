import json
import os
from dataclasses import dataclass, asdict
from typing import List


DATA_DIR = os.path.join(os.path.dirname(__file__), '..', 'data')

class Cliente:
    def __init__(self, id, name, email, password, telephone, is_locador, cpf , endereco, historico_aluguel : list,  locacao_atual_id):
        self.id = id
        self.name = name
        self.email = email
        self.password = password
        self.telephone = telephone
        self.is_locador = is_locador
        self.cpf = cpf
        self.endereco = endereco
        self.historico_aluguel = historico_aluguel
        self.locacao_atual_id = locacao_atual_id

    def __repr__(self):
        return (f"Cliente(id={self.id}, name='{self.name}', email='{self.email}', "
                f"password='{self.password}', telephone='{self.telephone}',"
                f"is_locador='{self.is_locador}', cpf='{self.cpf}',"
                f"endereco='{self.endereco}', historico_aluguel='{self.historico_aluguel}',"
                f"locacao_atual_id='{self.locacao_atual_id}')")

    def to_dict(self):
        return {
            'id': self.id,
            'name': self.name,
            'email': self.email,
            'password': self.password,
            'telephone': self.telephone,
            'is_locador': self.is_locador,
            'cpf': self.cpf,
            'endereco': self.endereco,
            'historico_aluguel': self.historico_aluguel,
            'locacao_atual_id': self.locacao_atual_id
        }

    @classmethod
    def from_dict(cls, data):
        return cls(
            id=data['id'],
            name=data['name'],
            email=data['email'],
            password=data['password'],
            telephone=data['telephone'],
            is_locador=data['is_locador'],
            cpf=data['cpf'],
            endereco=data['endereco'],
            historico_aluguel=data['historico_aluguel'],
            locacao_atual_id=data['locacao_atual_id']
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
            return [Cliente(**item) for item in data]

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
