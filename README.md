<div align="center">
  <h1>Glovebox</h1>
  <p>Homomorphic computing server (concept(s))</p>
  <br>
  <img src="./glovebox.png" width="200">
</div>

## Background
Traditional cryptosystems enable encrytpion of data *at rest* and *in transit*, but this data must be *decrypted* to perform useful computations on it (simple primitives like XOR up to more complex operations such as machine learning and data science). Fully homomorphic encryption (FHE) is considered the "holy grail" of encryption schemes because it enables computation on encrypted data and is theoretically quantum resistant.

## Docker setup
Build docker container:
```
docker build -t glovebox .
```

Run docker container (with Jupyter server):
```
docker run -d -p 8888:8888 glovebox
```

The container can be interacted with using:
```
docker exec -it <container-name> /bin/bash
```
