import sys
from pyral import Rally, rallySettings
options = [arg for arg in sys.argv[1:] if arg.startswith('--')]
args = [arg for arg in sys.argv[1:] if arg not in options]
server, user, password, workspace, project = rallySettings(options)
rally = Rally(server, user, password, workspace=workspace, project=project)
rally.enableLogging('mypyral.log')
