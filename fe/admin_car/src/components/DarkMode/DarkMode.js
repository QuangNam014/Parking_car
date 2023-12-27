import { useColorScheme } from '@mui/material';

import { DarkModeToggle } from '@anatoliygatt/dark-mode-toggle';

function DarkMode(props) {
    const { mode, setMode } = useColorScheme();

    return (
        <div>
            <DarkModeToggle
                mode={mode}
                dark="Dark"
                light="Light"
                size="sm"
                onChange={() => {
                    setMode(mode === 'light' ? 'dark' : 'light');
                }}
            />
        </div>
    );
}

export default DarkMode;
