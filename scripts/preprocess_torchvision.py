import torchvision

torchvision.datasets.FashionMNIST(".", train=True, download=True)
torchvision.datasets.FashionMNIST(".", train=False, download=True)
