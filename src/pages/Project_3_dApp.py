"""Main module for the streamlit app"""
import streamlit as st

import awesome_streamlit as ast
import erik_app
# import character_Model

ast.core.services.other.set_logging_format()

PAGES = {
    "ERC-721 - Mint an NFT!": erik_app,
}


def main():
    """Main function of the App"""
    st.sidebar.title("Navigation - Choose your application you want to work with")
    selection = st.sidebar.radio("Go to", list(PAGES.keys()))

    page = PAGES[selection]

    # with st.spinner(f"Loading {selection} ..."):
    #     ast.shared.components.write_page(page)

    st.sidebar.title("About")
    st.sidebar.info(
        """
        This app was created by Team 1 of the Fintech Bootcamp consisting of:
        
        Pete DiBona        
        Erik Larson        
        Pradeep Dahal        
        Alek Birkeland          
        John Melvin
"""
    )


if __name__ == "__main__":
    main()