"""Main module for the streamlit app"""
import streamlit as st

import awesome_streamlit as ast
# import erik_app
import character_Model

ast.core.services.other.set_logging_format()

PAGES = {
    "ERC-1155": character_Model,
}


def main():
    """Main function of the App"""
    st.sidebar.title("Navigation")
    selection = st.sidebar.radio("Go to", list(PAGES.keys()))

    page = PAGES[selection]

    # with st.spinner(f"Loading {selection} ..."):
    #     ast.shared.components.write_page(page)
    st.sidebar.title("Contribute")
    st.sidebar.info(
        "This an open source project and you are very welcome to **contribute** your awesome "
        "comments, questions, resources and apps as "
        "[issues](https://github.com/MarcSkovMadsen/awesome-streamlit/issues) of or "
        "[pull requests](https://github.com/MarcSkovMadsen/awesome-streamlit/pulls) "
        "to the [source code](https://github.com/MarcSkovMadsen/awesome-streamlit). "
    )
    st.sidebar.title("About")
    st.sidebar.info(
        """
        This app is maintained by Marc Skov Madsen. You can learn more about me at
        [datamodelsanalytics.com](https://datamodelsanalytics.com).
"""
    )


if __name__ == "__main__":
    main()