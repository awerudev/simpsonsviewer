
ensure_flutter_version: 
	fvm install stable
	fvm global stable

melos_clean:
	melos run clean

melos_pub_get:
	melos run pub_get

melos_l1on:
	melos run l10n

melos_build_runner:
	melos run build_runner

melos_format:
	melos run format

melos_rebuild: ensure_flutter_version melos_pub_get melos_l1on melos_build_runner melos_format
	