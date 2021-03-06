from .providers import provider_registry


class ProviderManager:
    def __init__(self, manifest_manager, dirs):                
        self.manifest_manager = manifest_manager
        self.dirs = dirs
        self.providers = {}

    def get(self, name):
        if name in self.providers:
            return self.providers[name]

        for context in self.manifest_manager.providers:
            if name == context["name"]:
                self.providers[name] = self.init_provider(context)
                break
        else:
            raise Exception(f"provider {name} does not exist")

        return self.providers[name]
    
    def init_provider(self, context):        
        assert context["type"] in provider_registry, "logic error"
        clazz = provider_registry[context["type"]]     

        return clazz(context["prop"])
