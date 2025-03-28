include .env.local

all:
	bash -c 'source ~/.nvm/nvm.sh && nvm install -b --skip-default-packages --latest-npm --no-progress --default --lts'
	bash -c 'source ~/.nvm/nvm.sh && nvm install-latest-npm'
	bash -c 'source ~/.nvm/nvm.sh && nvm use --lts'

knip:
	@echo '{'                                           > .knip.json
	@echo '  "entry": ['                               >> .knip.json
	@echo '    "amplify/backend.ts"'                   >> .knip.json
	@echo '  ],'                                       >> .knip.json
	@echo '  "project": ['                             >> .knip.json
	@echo '    "**/*.{js,cjs,mjs,jsx,ts,cts,mts,tsx}"' >> .knip.json
	@echo '  ],'                                       >> .knip.json
	@echo '  "ignore": ['                              >> .knip.json
	@echo '  ],'                                       >> .knip.json
	@echo '  "ignoreDependencies": ['                  >> .knip.json
#	@echo '    "@aws-amplify/backend-cli",'            >> .knip.json
#	@echo '    "aws-cdk",'                             >> .knip.json
#	@echo '    "esbuild",'                             >> .knip.json
#	@echo '    "tsx"'                                  >> .knip.json
	@echo '  ]'                                        >> .knip.json
	@echo '}'                                          >> .knip.json
	npx knip

updates:
	npx npm-check-updates \
		--interactive \
		--format group 

#		--reject \
#		react,react-dom,@types/react,@types/react-dom,next,eslint,eslint-config-next,tailwindcss

init:
# 2024-12 @aws-amplify/ui-react doesn't support react 19
#	npx create-next-app@latest content --ts --tailwind --eslint --app --src-dir --import-alias '@/*' --use-npm
	npx shadcn@latest init
	rsync -a \
		--delete \
		--exclude .git \
		--exclude .env.local \
		--exclude .vscode \
		--exclude CONVENTIONS.md \
		--exclude Makefile \
		--exclude PROJECT_GOAL.md \
		--exclude my-app/ \
		my-app/ .
	rm -rf my-app
	npm create amplify@latest
#	npm install @aws-amplify/ui-react

shadcn:
	npx shadcn@latest add button

clean:
	-rm -rf .next node_modules

real-clean: clean
	find . -mindepth 1 \
		-not -name '.git' \
		-not -path './.git/*' \
		-not -name .env.local \
		-not -name CONVENTIONS.md \
		-not -name Makefile \
		-not -name PROJECT_GOAL.md \
		-not -name '.' \
		-exec rm -rf {} +
