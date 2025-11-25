import json
import os
from dataclasses import dataclass, asdict
from typing import List

DATA_DIR = os.path.join(os.path.dirname(__file__), '..', 'data')

class Locacao:
    def __init__(self, id, locador_id, cliente_id, veiculo_id, data_inicio, data_fim, valor_total , status):
        self.id = id
        self.locador_id = locador_id
        self.cliente_id = cliente_id
        self.veiculo_id = veiculo_id
        self.data_inicio = data_inicio
        self.data_fim = data_fim
        self.valor_total = valor_total
        self.status = status

    def __repr__(self):
        return (f"Locacao(id={self.id}, locador_id='{self.locador_id}', cliente_id='{self.cliente_id}', "
                f"veiculo_id='{self.veiculo_id}', data_inicio='{self.data_inicio}', "
                f"data_fim='{self.data_fim}', valor_total='{self.valor_total}',"
                f"status='{self.status}')")

    def to_dict(self):
        return {
            'id': self.id,
            'locador_id': self.locador_id,
            'cliente_id': self.cliente_id,
            'veiculo_id': self.veiculo_id,
            'data_inicio': self.data_inicio,
            'data_fim': self.data_fim,
            'valor_total': self.valor_total,
            'status': self.status
        }

    @classmethod
    def from_dict(cls, data):
        return cls(
            id=data['id'],
            locador_id=data['locador_id'],
            cliente_id=data['cliente_id'],
            veiculo_id=data['veiculo_id'],
            data_inicio=data['data_inicio'],
            data_fim=data['data_fim'],
            valor_total=data['valor_total'],
            status=data['status']
        )


class LocacaoModel:
    FILE_PATH = os.path.join(DATA_DIR, 'locacoes.json')
    
    def __init__(self):
        self.locacoes = self._load()

    def _load(self):
        if not os.path.exists(self.FILE_PATH):
            return []
        with open(self.FILE_PATH, 'r', encoding='utf-8') as f:
            data = json.load(f)
            return [Locacao(**item) for item in data]

    def _save(self):
        with open(self.FILE_PATH, 'w', encoding='utf-8') as f:
            json.dump([l.to_dict() for l in self.locacoes], f, indent=4, ensure_ascii=False)

    def get_all(self):
        return self.locacoes

    def get_by_id(self, locacao_id: int):
        return next((l for l in self.locacoes if l.id == locacao_id), None)

    def add_locacao(self, locacao: Locacao):
        self.locacoes.append(locacao)
        self._save()

    def update_locacao(self, updated_locacao: Locacao):
        for i, locacao in enumerate(self.locacoes):
            if locacao.id == updated_locacao.id:
                self.locacoes[i] = updated_locacao
                self._save()
                break

    def delete_locacao(self, locacao_id: int):
        self.locacoes = [l for l in self.locacoes if l.id != locacao_id]
        self._save()
