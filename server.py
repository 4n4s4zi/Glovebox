from openfhe import *

def main():

  params = CCParamsBFVRNS()
  params.SetMultiplicativeDepth(2)

  crypto_context = GenCryptoContext(params)

  key_pair = crypto_context.KeyGen()



if __name__ == "__main__":
  main()
