import SideBar from '~/pages/global/SideBar/SideBar';
import TopBar from '~/pages/global/TopBar/TopBar';

function Layout({ children }) {
    return (
        <div className="app">
            <SideBar />
            <div className="content">
                <TopBar />
                {children}
            </div>
        </div>
    );
}

export default Layout;
