import React from 'react'

const BACKGROUND_STYLE = {
    position : 'fixed',
    top : '0',
    bottom : '0',
    left : '0',
    right : '0',
    backgroundColor : 'rgb(0,0,0,0.7)',
    zIndex : '1000'
}

const MODAL_STYLE = {
    position : 'fixed',
    top : '50%',
    left : '50%',
    transform : 'translate(-50%, -50%)',
    // padding : '5px',
    border: "2px solid rgb(0, 0, 0)",
    backgroundColor : 'rgb(255, 255, 255)',
    // borderRadius : '10px',
    color : 'black',
}

export default function Modal({isOpen, children}) {

    if(isOpen) {
        return (
            <div style={BACKGROUND_STYLE}>
                <div style={MODAL_STYLE}>
                    <div>
                        {children}
                    </div>
                </div>
            </div>
        )
    }

    return null
}
