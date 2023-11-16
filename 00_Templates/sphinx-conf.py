####################################################################################################
#                                                        ___   ___                               
#     //   ) )         //   ) )         //    / /           / /            /|    / /      \\ / / 
#    ((               //___/ /         //___ / /           / /            //|   / /        \  /  
#      \\            / ____ /         / ___   /           / /            // |  / /         / /   
#        ) )        //               //    / /           / /            //  | / /         / /\\  
# ((___ / /        //               //    / /         __/ /___         //   |/ /         / /  \\ 
#                                                                                                
#     //   ) )         //   ) )         /|    / /         //   / /        //   ) )     \\    / / 
#    //               //   / /         //|   / /         //___           //___/ /       \\  / /  
#   //               //   / /         // |  / /         / ___           / ____ /         \\/ /   
#  //               //   / /         //  | / /         //              //                 / /    
# ((____/ /        ((___/ /         //   |/ /         //          ()  //                 / /      
# by (github.com/t-truong)
# Configuration file for { sphinx-quickstart }
####################################################################################################





#Paths==============================================================================================
import os; import sys; sys.dont_write_bytecode= True
sys.path.insert(0, os.path.abspath("../../")) #insert path to source code containing documentation





#Project Information================================================================================
project  = "Name"
release  = '1.0'
author   = 't-truong'
copyright= "2023, t-truong"





#Behavior===========================================================================================
templates_path  = ['_templates']
exclude_patterns= []

master_doc= "00_INDEX"              #change the master document file (aka. home page) from the default "index.rst"
extensions= ["sphinx.ext.napoleon", #for NumPy styled docstrings which this standard is based off of
             "sphinx.ext.viewcode"] #this automatically creates a link to the source code for every documentation Python class/function





#Visuals============================================================================================
html_theme      = 'alabaster'
html_static_path= ['_static']
# html_logo       = "logo.png"  #path to logo image

rst_prolog= """
.. role:: python(code)
    :language: python
    :class: highlight
"""





####################################################################################################
#                                                        ___   ___                               
#     //   ) )         //   ) )         //    / /           / /            /|    / /      \\ / / 
#    ((               //___/ /         //___ / /           / /            //|   / /        \  /  
#      \\            / ____ /         / ___   /           / /            // |  / /         / /   
#        ) )        //               //    / /           / /            //  | / /         / /\\  
# ((___ / /        //               //    / /         __/ /___         //   |/ /         / /  \\ 
#                                                                                                
#     //   ) )         //   ) )         /|    / /         //   / /        //   ) )     \\    / / 
#    //               //   / /         //|   / /         //___           //___/ /       \\  / /  
#   //               //   / /         // |  / /         / ___           / ____ /         \\/ /   
#  //               //   / /         //  | / /         //              //                 / /    
# ((____/ /        ((___/ /         //   |/ /         //          ()  //                 / /      
# by (github.com/t-truong)
# Configuration file for { sphinx-quickstart }
####################################################################################################
