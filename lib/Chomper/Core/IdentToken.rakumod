our role IdentToken {

    token identifier {
        <[A..Z a..z _]> <[A..Z a..z 0..9 _]>*
    }

    token extended-identifier {
        <[A..Z a..z _]> <[A..Z a..z 0..9 _ : < > ]>*
    }

    token namespaced-extended-identifier {
        <extended-identifier>+ %% "::"
    }

    token name {
        <.identifier>
    }
}
