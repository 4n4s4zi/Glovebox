<div align="center">
  <h1>Glovebox</h1>
  <p>Homomorphic computing server</p>
  <br>
  <img src="./glovebox.png" width="200">
</div>

## Background
Traditional cryptosystems enable encrytpion of data *at rest* and *in transit*, but this data must be *decrypted* to perform useful computations on it (simple primitives like XOR up to more complex operations such as machine learning and data analytics). Fully homomorphic encryption (FHE) is considered the "holy grail" of encryption schemes because it enables computation on encrypted data and is theoretically quantum resistant.

(Currently just using this to mess around with FHE concepts)

## Docker setup
Build docker container:
```
docker build -t glovebox .
```

Run docker container (with Jupyter server):
```
docker run -d -p 8888:8888 glovebox
```

The container can be interacted with using jupyterlab on port 8888 or by enabling the interactive terminal directly through Docker:
```
docker exec -it <container-name> /bin/bash
```

## Resources
- [OpenFHE](https://github.com/openfheorg/openfhe-development)
- [OpenFHE Python Wrapper](https://github.com/openfheorg/openfhe-python)
- [TFHE (FHE scheme with support for basic binary gates (AND, OR, XOR, ...))](https://github.com/tfhe/tfhe)
- [TFHE-rs (latest TFHE implementation, in rust)](https://github.com/zama-ai/tfhe-rs)
- [Concrete (FHE compiler, currently only supports python)](https://github.com/zama-ai/concrete)


