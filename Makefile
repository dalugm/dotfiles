default:
	stow .
	ln -s ${HOME}/.config/zsh/.zshrc ${HOME}/.zshrc
	ln -s ${HOME}/.config/bash/.bashrc ${HOME}/.bashrc

clean:
	stow -D .
	rm ${HOME}/.zshrc ${HOME}/.bashrc
