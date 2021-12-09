import os
import json
from web3 import Web3
from pathlib import Path
from dotenv import load_dotenv
import streamlit as st
from character_Model import Character
import character_Model as model

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

    # Load ERC 721 ABI
    with open(Path('../artifacts/kitsune-721_abi.json')) as f:
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

accounts = w3.eth.accounts
account = accounts[0]
user_account = st.selectbox("Select the account you would like to receive the ERC-721 into.", options=accounts)
# st.text(f'User Account: {user_account}')
# certificate_details = st.text_input("Certificate Details", value="FinTech Certificate of Completion")
# if st.button("Award Certificate"):
#     contract.functions.awardCertificate(student_account, certificate_details).transact({'from': account, 'gas': 1000000})

################################################################################
# Mint New Character
################################################################################
st.markdown("## Create a new character")

character_name = st.text_input("Enter the Name of the character")
character_class = st.text_input("Enter the Class of the character")
agility = st.number_input("Enter the Agility of the character", step=1)
strength = st.number_input("Enter the Strength of the character", step=1)
generation = st.number_input("Enter the generation of the character", step=1)


if st.button("Create Character"):
    # App function to create a Character
    new_char = model.Character(character_name, character_class, strength, agility, generation)
    st.text(f'Name: {new_char.character_name}, class: {new_char.character_class}, Agility: {new_char.agility}, Str: {new_char.strength}, Gen: {new_char.generation}')

    new_char_id = contract.functions.mint_character(
        user_account,
        new_char.character_name,
        new_char.character_class,
        new_char.strength,
        new_char.agility,
        new_char.generation
    ).transact({'from': user_account, 'gas': 1000000})
    st.text(f'Your new Character ID is {new_char_id}.')
    # st.text(f'The address of the character is {owner}.')

################################################################################
# Display Character
################################################################################
characterId = st.number_input("Enter a Character ID to display", value=1, step=1)
if st.button("Display Character"):
    # Get the character owner
    character_owner_address = contract.functions.ownerOf(characterId).call()
    st.write(f"The character belongs to {character_owner_address}")

    # Get the character's metadata
    character_uri = contract.functions.tokenURI(characterId).call()
    st.write(f"The character's tokenURI metadata is {character_uri}")
    character_attributes = contract.functions.characters(characterId).call()
    st.write(f'Character Name: {character_attributes[0]}, Character Class: {character_attributes[1]}')
 


