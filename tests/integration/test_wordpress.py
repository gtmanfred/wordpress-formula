import requests


def test_server(host_ip, http_port):
    assert requests.get(f'http://{host_ip}:{http_port}', headers={'Host': 'blog.manfred.io'})
