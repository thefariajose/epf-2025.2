from .basemodel import BasePerfil, BaseModel

class Cliente(BasePerfil):
    def __init__(self, id, name, email, password, telephone, is_locador, cpf, endereco, historico_aluguel=None, locacao_atual=None):
        super().__init__(id, name, email, password, telephone, is_locador)
        self.cpf = cpf
        self.endereco = endereco
        self.historico_aluguel = historico_aluguel if historico_aluguel else []
        self.locacao_atual = locacao_atual

    def to_dict(self):
        from models.locacao import Locacao 
        data = self.__dict__.copy()
        data['locacao_atual'] = self.locacao_atual.to_dict() if self.locacao_atual and hasattr(self.locacao_atual, 'to_dict') else self.locacao_atual
        data['historico_aluguel'] = [l.to_dict() if hasattr(l, 'to_dict') else l for l in self.historico_aluguel]
        return data

    @classmethod
    def from_dict(cls, data):
        from models.locacao import Locacao
        d = data.copy()
        if d.get('locacao_atual'):
            d['locacao_atual'] = Locacao.from_dict(d['locacao_atual'])
        hist = []
        if d.get('historico_aluguel'):
            for item in d['historico_aluguel']:
                hist.append(Locacao.from_dict(item))
        d['historico_aluguel'] = hist
        return cls(**d)

class ClienteModel(BaseModel):
    def __init__(self):
        super().__init__('clientes.json', Cliente)