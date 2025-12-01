from .basemodel import BasePerfil, BaseModel

class Locador(BasePerfil):
    #Constructor
    def __init__(self, id, name, email, password, telephone, is_locador, cnpj, veiculos=None):
        super().__init__(id, name, email, password, telephone, is_locador)
        self.cnpj = cnpj
        self.veiculos = veiculos if veiculos else []
    #semelhante a cliente
    def to_dict(self):
        data = self.__dict__.copy()
        data['veiculos'] = [v.to_dict() if hasattr(v, 'to_dict') else v for v in self.veiculos]
        return data

    @classmethod
    def from_dict(cls, data):
        from models.vehicles import Vehicle
        d = data.copy()
        if 'historico_locacoes' in d:
            del d['historico_locacoes']
            
        veiculos_list = []
        if d.get('veiculos'):
            for item in d['veiculos']:
                veiculos_list.append(Vehicle.from_dict(item))
        d['veiculos'] = veiculos_list
        
        return cls(**d)

class LocadorModel(BaseModel):
    def __init__(self):
        super().__init__('locador.json', Locador)