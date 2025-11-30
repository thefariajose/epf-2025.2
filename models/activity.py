#Classe que possivelmente ainda será removida do projeto
class Activity:
    def __init__(self, id, name, description, done):
        self.id = id
        self.name = name
        self.description = description
        self.done = done

    def to_dict(self):
        return {
            'id': self.id,
            'name': self.name,
            'description': self.description,
            'done': self.done
        }

    @classmethod
    def from_dict(cls, data):
        return cls(**data)

#no geral, próximo do user
class ActivityModel:
    #aqui define o file path exatamente, diferente do outro que usa a função lá os.path.join
    FILE_PATH = 'data/activities.json'

    def __init__(self):
        self.activities = self._load()

    def _load(self):
        import json, os
        if not os.path.exists(self.FILE_PATH):
            return []
        #bem próximo do user
        with open(self.FILE_PATH, 'r', encoding='utf-8') as f:
            return [Activity.from_dict(item) for item in json.load(f)]
            #retorna iteração do item em dict, cada iteração json salva f em uma lista de dicts em python

    def _save(self):
        import json
        with open(self.FILE_PATH, 'w', encoding='utf-8') as f:
            #aqui o json dump pega os arquivos e salva em um dicionário 
            json.dump([a.to_dict() for a in self.activities], f, indent=4, ensure_ascii=False)

    def get_all(self):
        return self.activities

    def get_by_id(self, activity_id):
        return next((a for a in self.activities if a.id == activity_id), None)

    def add(self, activity):
        self.activities.append(activity)
        self._save()

    def update(self, updated_activity):
        for i, a in enumerate(self.activities):
            if a.id == updated_activity.id:
                self.activities[i] = updated_activity
                self._save()
                break

    def delete(self, activity_id):
        self.activities = [a for a in self.activities if a.id != activity_id]
        self._save()