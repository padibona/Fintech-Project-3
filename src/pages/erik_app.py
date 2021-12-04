import os
import json
from web3 import Web3
from pathlib import Path
from dotenv import load_dotenv
import streamlit as st
from character_Model import Character

load_dotenv()

# Define and connect a new Web3 provider
w3 = Web3(Web3.HTTPProvider(os.getenv("WEB3_PROVIDER_URI")))

################################################################################
# Contract Helper function:
# 1. Loads the contract once using cache
# 2. Connects to the contract using the contract address and ABI
################################################################################

# Cache the contract on load
@st.cache(allow_output_mutation=True)
# Define the load_contract function
def load_contract():

    # Load Art Gallery ABI
    with open(Path('./contracts/compiled/certificate_abi.json')) as f:
        certificate_abi = json.load(f)

    # Set the contract address (this is the address of the deployed contract)
    contract_address = os.getenv("SMART_CONTRACT_ADDRESS")

    # Get the contract
    contract = w3.eth.contract(
        address=contract_address,
        abi=certificate_abi
    )
    # Return the contract from the function
    return contract


# Load the contract
contract = load_contract()


################################################################################
# Award Certificate
################################################################################

# accounts = w3.eth.accounts
# account = accounts[0]
# student_account = st.selectbox("Select Account", options=accounts)
# certificate_details = st.text_input("Certificate Details", value="FinTech Certificate of Completion")
# if st.button("Award Certificate"):
#     contract.functions.awardCertificate(student_account, certificate_details).transact({'from': account, 'gas': 1000000})

################################################################################
# Display Certificate
################################################################################
characterId = st.number_input("Enter a Certificate Token ID to display", value=0, step=1)
if st.button("Display Character"):
    # Get the certificate owner
    character_owner = contract.functions.ownerOf(characterId).call()
    st.write(f"The certificate was awarded to {character_owner}")

    # Get the certificate's metadata
    character_uri = contract.functions.tokenURI(characterId).call()
    st.write(f"The certificate's tokenURI metadata is {character_uri}")


################################################################################
# Mint New Character
################################################################################
st.markdown("## Create a new character")

character_name = st.text_input("Enter the name of the character")

if st.button("Create Character"):
    # App function to create a Character
    contract.functions.mint_character(Character.create_new_character(character_name))
