from .basemodel import BasePerfil, BaseModel

#Cliente tem a função de escolher o carro a ser alugado. Métodos dessa classe são herdados e alterados
class Cliente(BasePerfil):
    #Constructor
    def __init__(self, id, name, email, password, telephone, is_locador, cpf, endereco, historico_aluguel=None, locacao_atual=None):
        super().__init__(id, name, email, password, telephone, is_locador)
        self.cpf = cpf
        self.endereco = endereco
        self.historico_aluguel = historico_aluguel if historico_aluguel else []
        self.locacao_atual = locacao_atual

    def to_dict(self):
        data = self.__dict__.copy()
        data['locacao_atual'] = self.locacao_atual.to_dict() if self.locacao_atual and hasattr(self.locacao_atual, 'to_dict') else self.locacao_atual
        historico_formatado = []
        for l in self.historico_aluguel:
            if hasattr(l, 'to_dict'):
                historico_formatado.append(l.to_dict())
            else:
                historico_formatado.append(l)
        data['historico_aluguel'] = historico_formatado
        return data
        #Copia os dados brutos,  locacao atual basicamente verifica se existe, se 
        # é um objeto convertivel "hasattr",
        # pq teria o to dict internamente, se não mantém a self.locacao atual
        
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
    #converte do dicionario em um obj 
#passa a localização da pasta json e a classe entidade
class ClienteModel(BaseModel):
    def __init__(self):
        super().__init__('clientes.json', Cliente)