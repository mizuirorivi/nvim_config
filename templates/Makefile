CC = gcc
CFLAGS = -Wall -Wextra -O2
LDFLAGS = 

# プロジェクトの名前とソースファイルのリスト
TARGET = myapp
SRCS = main.c utils.c
OBJS = $(SRCS:.c=.o)

# デフォルトのターゲット (通常は all)
all: $(TARGET)

# 実行ファイルのビルド
$(TARGET): $(OBJS)
	$(CC) $(LDFLAGS) -o $(TARGET) $(OBJS)

# 個々のオブジェクトファイルのビルド
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# クリーンアップ (生成されたファイルの削除)
clean:
	rm -f $(OBJS) $(TARGET)

# その他のターゲット (例えば、テストやインストール)
install: $(TARGET)
	# インストールコマンドを書く
	# 例: cp $(TARGET) /usr/local/bin/

test: $(TARGET)
	# テスト用のコマンドを書く
	# 例: ./$(TARGET) --test

# .PHONYターゲットの指定 (ファイル名と被らないように)
.PHONY: all clean install test
