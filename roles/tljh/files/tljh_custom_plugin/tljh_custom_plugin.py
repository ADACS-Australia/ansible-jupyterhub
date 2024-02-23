from tljh.hooks import hookimpl
from tljh.config import CONFIG_FILE
from tljh.yaml import yaml
import subprocess

@hookimpl
def tljh_new_user_create(username):

    # Read tljh-config file
    try:
        with open(CONFIG_FILE) as f:
            config = yaml.load(f)
    except FileNotFoundError:
        config = {}

    # Try to get `quota` from it
    try:
        quota = config['quota']
    except:
        print('ERROR: could not read quota from tljh-config. Using default 2G.', flush=True)
        quota = '2G'

    print('Setting quota for user: {user}\n'.format(user=username), flush=True)
    
    try:
        subprocess.check_call(['setquota', '-a', '-u', username, quota, quota, '0' ,'0'])
    except subprocess.CalledProcessError:
        print('ERROR in {loc}'.format(loc=__file__), flush=True)
        print('Could not edit quota for user {user}'.format(user=username), flush=True)
        print('[Quotas may not be enabled on the filesystem]', flush=True)
    
    try:
        subprocess.check_call(['quota','-us', username])
    except subprocess.CalledProcessError:
        print("ERROR: could not show quota for {user}".format(user=username), flush=True)


@hookimpl
def tljh_custom_jupyterhub_config(c):
    import os, nativeauthenticator
    if c.JupyterHub.authenticator_class == 'nativeauthenticator.NativeAuthenticator':
        c.JupyterHub.template_paths = ['{}/templates/'.format(os.path.dirname(nativeauthenticator.__file__))]
