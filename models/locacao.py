from .basemodel import Base, BaseModel

class Locacao(Base):
    def __init__(self, id, locador_id, cliente_id, veiculo_id, data_inicio, data_fim, valor_total, status):
        super().__init__(id)
        self.locador_id = locador_id
        self.cliente_id = cliente_id
        self.veiculo_id = veiculo_id
        self.data_inicio = data_inicio
        self.data_fim = data_fim
        self.valor_total = valor_total
        self.status = status

    def to_dict(self):
        return self.__dict__

    @classmethod
    def from_dict(cls, data):
        data.setdefault('data_fim', None)
        return cls(**data)

class LocacaoModel(BaseModel):
    def __init__(self):
        super().__init__('locacoes.json', Locacao)